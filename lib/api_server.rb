require 'database'
require 'json'

class ApiServer
  def call(env)
    request = Rack::Request.new env
    method = request.request_method
    path = request.path
    response_code = 404
    response_headers = { 'content-type' => 'application/json' }
    response_body = ['Not Found']
    if method == 'GET'
      if path.match /^\/top-post(\?.*?)?$/
        n = request.params['n'] # pick the top n posts
        if n
          top_posts = Post.select('posts.title, posts.content')
                          .joins(:ratings)
                          .group('posts.id')
                          .order('avg(ratings.value) desc')
                          .first(n.to_i)
                          .map { |item| { title: item.title,  content: item.content } }
        else
          top_posts = Post.select('posts.title, posts.content')
                          .joins(:ratings)
                          .group('posts.id')
                          .order('avg(ratings.value) desc')
                          .first(5)
                          .map { |item| { title: item.title,  content: item.content } }
        end
        response_code = 200
        response_body = [top_posts.to_json]
      elsif path.match  /^\/get-ip-listings$/
        posts = Post.select(:user_id, :ip_address).distinct.includes(:user)
        result = {}
        posts.each do |post|
          if result.include?(post.ip_address)
            result[post.ip_address] << post.user.login
          else
            result[post.ip_address] = [post.user.login]
          end
        end
        end_result = result.to_h.map { |item| { 'ip_address' => item[0], 'logins' => item[1] } }
        response_code = 200
        response_body = [end_result.to_json]
      end
    elsif method == 'POST'
      if path.match /^\/post$/
        user = User.find_or_create_by(login: request.params['login'])
        post = user.posts.build(title: request.params['title'], content: request.params['content'], ip_address: request.params['ip_address'])
        if post.save
          response_code = 200
          response_body = [post.to_json]
        else
          response_code = 422
          response_body = [{ errors: post.errors.full_messages }.to_json]
        end
      elsif path.match /^\/post\/rate$/
        post = Post.find_by(id: request.params['post_id'])
        if post
          rating = post.ratings.build(value: request.params['value'])
          if rating.save
            response_code = 200
            response_body = [{ average_rating: post.ratings.average(:value) }.to_json]
          end
        end
      end
    end
    [response_code, response_headers, response_body]
  end
end
