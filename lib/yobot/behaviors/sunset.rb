class Yobot::Behaviors::Dict
  def react(room, message)
    if message =~ /^sunset/
      request = EventMachine::HttpRequest.new('http://api.geonames.org/timezoneJSON')
      http = request.get(query: {username: 'jed', lat: '52.500052354529245', lon: '13.419971466064453'})
      http.callback do
        room.text("the sun sets today at #{JSON.parse(http.response)['sunset'].split(' ')[1]}") {}
      end
    end
  end
end