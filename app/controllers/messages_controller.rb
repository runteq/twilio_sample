class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  protect_from_forgery with: :null_session, only: %i[update]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        @message.call
        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    result = params[:Digits].to_i
    @message.update!(result: result)
    msg = Twilio::TwiML::VoiceResponse.new do |r|
      r.say voice: 'Alice', language: 'ja-JP', message: 'ご利用ありがとうございました'
    end
    render xml: msg
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:phone_number, :from_name, :to_name, :message)
    end
end
