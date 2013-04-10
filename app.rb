require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

 #set up a class called puzzle that will store the id, the last name, for the student we are setting up  
 
class Profile
  include DataMapper::Resource
  property :id, Serial
  property :first, String
  property :last, String
  property :bio, String
 
 

end

get '/' do

erb :profilestudent

end


post '/create_profile' do

profile = Profile.new
profile.first = params[:first]
profile.last = params[:last]
profile.bio = params[:bio]
profile.save



redirect "http://www.furaha-robin.com/~robinreid/sinatra/next_step/profile/#{profile.id}"
end



post '/save_image' do
  
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  redirect "http://www.furaha-robin.com/~robinreid/sinatra/next_step/profile/#{profile.id}"
  erb :publicstudent
end


get '/profile/:id' do

 @student = Profile.get(params[:id])

erb :publicstudent

end




