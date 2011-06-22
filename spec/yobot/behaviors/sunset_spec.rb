require 'spec_helper'

describe Yobot::Behaviors::Sunset do
  it "requests the sunset data" do
    request = stub(:request)

    EventMachine::HttpRequest.should_receive(:new).with(
  'http://api.geonames.org/timezoneJSON') {request}
    request.should_receive(:get).with(query: {username: 'yobot', lat: '52.500052354529245', lng: '13.419971466064453'}) {stub.as_null_object}

    Yobot::Behaviors::Sunset.new.react(stub, 'sunset')
  end
  
  it "also works when saying sunrise" do
    EventMachine::HttpRequest.should_receive(:new).with(
  'http://api.geonames.org/timezoneJSON') {stub.as_null_object}

    Yobot::Behaviors::Sunset.new.react(stub, 'sunrise')
  end
  
  it "prints out the sunset time" do
    room = stub
    request = stub(:request)
    http = stub(:http)
    EventMachine::HttpRequest.stub(:new) {request}
    request.stub(:get) {http}
    http.stub(:callback).and_yield
    http.stub(:response) {
      {"sunset" => "2011-06-22 21:33",
       "sunrise" => "2011-06-22 04:43",
       "timezoneId" => "Europe/Berlin"}.to_json
    }
    
    room.should_receive(:text).with('Sunrise in Europe/Berlin today is at 04:43, sunset at 21:33')

    Yobot::Behaviors::Sunset.new.react(room, 'sunset')
  end
end
