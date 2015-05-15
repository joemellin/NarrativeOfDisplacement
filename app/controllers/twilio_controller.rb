
class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def receive_call
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Welcome to the NARRATIVES OF DISPLACmeNT", :voice => 'man'
      response_main_decision_tree(r)
    end
    render :xml => response.text, :status => 200
  end

  def receive_main_decision_tree
    response = Twilio::TwiML::Response.new do |r|
      # Telegroup meeting (conference)
      if params[:Digits].to_i == 1
        r.Say 'You selected Nietos story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Nietos1.mp3'
      elsif params[:Digits].to_i == 2 
        r.Say 'You selected Tom and Patricias story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/TomP2.mp3'
      elsif params[:Digits].to_i == 3
        r.Say 'You selected Claudias story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Claudia3.mp3'
      elsif params[:Digits].to_i == 4
        r.Say 'You selected Pauls story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/PaulT4.mp3'
      elsif params[:Digits].to_i == 5 
        r.Say 'You selected Lisas story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/LisaG5.mp3'
      elsif params[:Digits].to_i == 6
        r.Say 'You selected Renitas story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/RenitaV6.mp3'
      elsif params[:Digits].to_i == 7
        r.Say 'You selected Benitos story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/BenitoS7.mp3'
      elsif params[:Digits].to_i == 8
        r.Say 'You selected Martinas story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Lotta8.mp3'
      elsif params[:Digits].to_i == 9
        r.Say 'You selected Rios story'
        r.Play 'https://s3.amazonaws.com/uploads.getnowapp.co/Rio9.mp3'
      else
        r.say "Can you try to call again?"
      end
    end
    render :xml => response.text, :status => 200
  end

  def receive_sms 

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hi! Call this number to listen to peoples NARRATIVES of displacement"
    end
    render :xml => twiml.text, :status => 200
  end
  
  private
  
  def response_main_decision_tree(r)
    r.Gather :timeout => 10, :numDigits => 1, :finishOnKey => '*', :action => receive_main_decision_tree_twilio_path do
      options = []
      options << 'Nietos'
      options += ['Tom and Patricias', 'Claudias','Pauls', 'Lisas','Renitas','Benitos','Lottas','Rios']
      c = 1
      options.each do |o|
        r.Say "Press #{c} to listen to #{o} story", :voice => 'man'
        r.Pause :length => 1
        c += 1
      end
    end
  end
end