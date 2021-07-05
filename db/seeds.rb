# Create 50 logins
# Create 200,000 posts
# Posts are rated randomly

require 'net/http'
require 'json'

# Sample data (random data thanks to mockaroo.com)
logins = ["lmackenny0",
          "bmessham1",
          "adomingues2",
          "abianco3",
          "rcristofalo4",
          "cmasic5",
          "pdestoop6",
          "cbrame7",
          "aenzley8",
          "glambert9",
          "gwoodruffea",
          "fkleslb",
          "kjanaudc",
          "amoyserd",
          "tlaistere",
          "rduddenf",
          "tmcleodg",
          "bsuffeh",
          "rionescoi",
          "nlockleyj",
          "ciannettik",
          "jburlel",
          "mdorotm",
          "lgoginn",
          "bogborno",
          "ntorrap",
          "gburreeq",
          "mmitror",
          "rfries",
          "jfurstt",
          "roclearyu",
          "nmuscottv",
          "ohacklyw",
          "mleveyx",
          "skindredy",
          "ppetelz",
          "eklouz10",
          "jmcgettrick11",
          "gprior12",
          "opershouse13",
          "kbroad14",
          "rbengough15",
          "rmcconnal16",
          "aczaja17",
          "csillito18",
          "tguidetti19",
          "hrens1a",
          "ncramer1b",
          "xbyforth1c",
          "isummerley1d",
          "anurden1e",
          "ihutcheson1f",
          "cdobbie1g",
          "jsircomb1h",
          "egreenman1i",
          "dduckhouse1j",
          "wmckinnon1k",
          "weustanch1l",
          "helwel1m",
          "zslocum1n",
          "clay1o",
          "rtivnan1p",
          "kkingsbury1q",
          "coxenbury1r",
          "ctidcomb1s",
          "dcowle1t",
          "satwater1u",
          "kburkart1v",
          "hvere1w",
          "mtrotman1x",
          "lgingles1y",
          "sdechastelain1z",
          "hrolfs20",
          "lposse21",
          "kcarncross22",
          "crottcher23",
          "mclappson24",
          "chardway25",
          "bphillput26",
          "kwassell27",
          "tsumbler28",
          "vbourley29",
          "tchifney2a",
          "mmccowan2b",
          "tgyver2c",
          "bburbury2d",
          "lhargey2e",
          "hughetti2f",
          "jgreenman2g",
          "ecoult2h",
          "ckellitt2i",
          "elempel2j",
          "rpostan2k",
          "wcucuzza2l",
          "ctewnion2m",
          "drobathon2n",
          "thassewell2o",
          "dbuckoke2p",
          "vcockling2q",
          "cmarco2r",
          "dnappin2s",
          "uskouling2t",
          "gdemichele2u",
          "jmaffeo2v",
          "aricards2w",
          "hcheesworth2x",
          "ctuke2y",
          "scretney2z",
          "nbunten30",
          "ahowlett31",
          "gnoble32",
          "nhutchinson33",
          "sbriscoe34",
          "ayearnes35",
          "abrandreth36",
          "vcanet37",
          "slamas38",
          "kmcasgill39",
          "bmyatt3a",
          "dcarrier3b",
          "cfrew3c",
          "lspinella3d",
          "bnann3e",
          "pyapp3f",
          "etruin3g"]

ip_addresses = ["19.212.199.115",
                "25.244.73.115",
                "243.30.109.174",
                "42.189.221.142",
                "112.76.213.117",
                "66.195.11.50",
                "48.247.175.63",
                "70.246.252.57",
                "90.67.165.91",
                "7.90.162.114",
                "184.110.85.134",
                "171.253.198.131",
                "126.168.134.54",
                "180.36.228.129",
                "180.96.42.203",
                "222.92.94.68",
                "136.32.28.176",
                "119.155.253.207",
                "10.72.35.37",
                "170.104.110.53",
                "164.168.94.171",
                "13.54.146.72",
                "188.42.97.89",
                "170.126.216.226",
                "235.236.225.27",
                "106.10.48.185",
                "94.30.210.66",
                "163.192.52.179",
                "96.183.110.226",
                "158.0.75.245",
                "2.192.140.245",
                "167.66.186.248",
                "79.200.54.58",
                "199.37.233.223",
                "20.79.72.134",
                "252.59.203.153",
                "32.202.222.178",
                "217.222.159.12",
                "176.68.188.220",
                "169.140.123.110",
                "25.197.64.78",
                "24.23.165.168",
                "42.201.48.223",
                "126.19.213.250",
                "209.22.145.112",
                "215.152.162.79",
                "96.149.147.122",
                "99.143.4.9",
                "144.141.82.100",
                "240.81.216.250"]

contents = [
  "Cheesecake queso croque monsieur. Melted cheese monterey jack brie when the cheese comes out everybody's happy roquefort parmesan bavarian bergkase feta. Pepper jack lancashire who moved my cheese chalk and cheese say cheese macaroni cheese halloumi ricotta. Paneer macaroni cheese jarlsberg.",
  "Monterey jack everyone loves fromage frais. Mozzarella parmesan gouda croque monsieur fromage boursin roquefort cow. Cheese and biscuits cheese and wine airedale fondue cut the cheese when the cheese comes out everybody's happy everyone loves cheese and biscuits. Caerphilly red leicester camembert de normandie.",
  "Caerphilly stilton cheddar. Bocconcini emmental caerphilly red leicester monterey jack manchego edam cream cheese. Fondue goat cut the cheese blue castello feta taleggio cauliflower cheese fromage frais. Cheddar cheeseburger feta cheesy feet edam roquefort everyone loves say cheese. Airedale cheese and wine.",
  "Who moved my cheese blue castello cheese slices. Cheese and biscuits mascarpone cheese on toast jarlsberg mascarpone monterey jack brie mozzarella. Parmesan cauliflower cheese fromage cream cheese bavarian bergkase cauliflower cheese macaroni cheese parmesan. Pecorino caerphilly taleggio cream cheese camembert de normandie cheese on toast.",
  "Macaroni cheese parmesan cheese and wine. Cauliflower cheese pecorino cheese on toast cheesecake cheesy grin stilton paneer ricotta. Stinking bishop cream cheese the big cheese babybel croque monsieur squirty cheese everyone loves red leicester. Melted cheese lancashire paneer cheesy grin mozzarella ricotta cream cheese cut the cheese. Melted cheese.",
]

# Endpoints    
create_post_uri = URI('http://localhost:9292/post')
rate_post_uri = URI('http://localhost:9292/post/rate')

puts 'Beginning to seed data ...'

logins.each do |username|
  1600.times do |i|
    post_data = {
      login: username,
      ip_address: ip_addresses.sample,
      title: "My Post #{i}",
      content: contents.sample,
    }
    res = Net::HTTP.post_form(create_post_uri, post_data)

    if res.code == '200'
      res_data = JSON.parse res.body
      puts "Successfully created Post id #{res_data['id']}"

      # rate this particular post with 50% probability
      if [true, false].sample
        puts "Now giving random ratings to Post id #{res_data['id']}"
        rand(1..50).times do |time|
          rate_data = {
            post_id: res_data['id'],
            value: rand(1..5)
          }
          res_for_rate = Net::HTTP.post_form(rate_post_uri, rate_data)
          if res_for_rate.code == '200'
            avg_rating = JSON.parse(res_for_rate.body)
            puts "Post id #{res_data['id']} now has an average rating of #{avg_rating['average_rating']}"
          end
        end
      end
    end
  end
end

puts 'Seeding done!'