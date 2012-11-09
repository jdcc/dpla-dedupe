require 'csv'
require 'open-uri'
require 'json'

if ARGV[0] 
end
match1 = File.open('recommend_match1.txt', 'w')
match2 = File.open('recommend_match2.txt', 'w')
CSV.foreach('recommend_weights', { :headers => true }) do |row|
    if row['Winkler-Creator-Creator'].to_f + row['Winkler-Subject-Subject'].to_f > 1.5
        record1 = JSON.parse(open('http://api.dp.la/v1/items/' + row['rec_id1']).read)[0]
        record2 = JSON.parse(open('http://api.dp.la/v1/items/' + row['rec_id2']).read)[0]
        match1.write('Title   : ' + record1['doc']['title'].to_s + "\n")
        match1.write('Subject : ' + record1['doc']['subject'][0]['name'] + "\n")
        if record1['doc']['creator']
            match1.write('Creator: ' + record1['doc']['creator'].to_s + "\n\n")
        else
            match1.write("\n\n\n")
        end
        match2.write('Title   : ' + record2['doc']['title'].to_s + "\n")
        match2.write('Subject : ' + record2['doc']['subject'][0]['name'] + "\n")
        if record2['doc']['creator']
            match2.write('Creator: ' + record2['doc']['creator'].to_s + "\n\n")
        else
            match2.write("\n\n\n")
        end
    end
end
