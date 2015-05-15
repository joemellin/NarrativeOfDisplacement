# Note: all TwiML Response methods use camelCase attribute names, but any API calls using the ruby gem have underscore_attribute names

class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token

  #calvin group 4 pin 71508 connection #1
  #keanu group 4 pin 76232 connection #2
  #laurel pin 8439

  #margaret group 12 pin 15830 connection #3
  #diane group 12 pin 75523 connection #1
  #Arinn pin 1300

  #Twilio number 1 415 682 6186

  
  # POST from Twilio when we receive a call
  def receive_call
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Welcome to Mission Stories", :voice => 'man'
      response_main_decision_tree(r)
    end
    render :xml => response.text, :status => 200
  end

  

  def receive_main_decision_tree
    response = Twilio::TwiML::Response.new do |r|
      # Telegroup meeting (conference)
      if params[:Digits].to_i == 1
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Nietos1.mp3'
      elsif params[:Digits].to_i == 2 #Community Connection
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/TomP2.mp3'
      elsif
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Claudia3.mp3'
      else
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/PaulT4.mp3'
      end
    end
    render :xml => response.text, :status => 200
  end

  def receive_sms 

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hi! Call this number to access your group and community connections."
    end
    render :xml => twiml.text, :status => 200
  end
  
  private
  
  def response_main_decision_tree(r)
    r.Gather :timeout => 10, :numDigits => 1, :finishOnKey => '*', :action => receive_main_decision_tree_twilio_path do
      options = []
      options << 'Nietos'
      options += ['Tom', 'Claudia','Paul']
      c = 1
      options.each do |o|
        r.Say "Press #{c} to #{o}", :voice => 'man'
        r.Pause :length => 1
        c += 1
      end
    end

  end

 

end