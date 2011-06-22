class Yobot::Behaviors::Sunset
  def react(room, message)
    if message =~ /^sunset|^sunrise/
      request = EventMachine::HttpRequest.new('http://api.geonames.org/timezoneJSON')
      http = request.get(query: {username: 'yobot', lat: '52.500052354529245', lng: '13.419971466064453'})
      http.callback do
        data = JSON.parse(http.response)
        room.text("Sunrise in #{data['timezoneId']} today is at #{data['sunrise'][-5..-1]}, sunset at #{data['sunset'][-5..-1]}") {}
      end
    end
  end
end