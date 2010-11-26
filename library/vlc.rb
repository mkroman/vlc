# encoding: utf-8

require 'open-uri'
require 'nokogiri'

module VLC
  Version = 1, 0, 0

module_function

  @host, @port = 'localhost', 8080

  def host= host; @host = host end
  def port= port; @port = port end

  def play filename = nil
    if filename
      request :in_play, input: filename
    else
      request :pl_play
    end
  end

  def pause; request :pl_pause end
  def clear; request :pl_clear end
  def stop;  request :pl_stop  end

  def add filename
    request :in_enqueue, input: filename
  end

  def request command, args = {}
    params = args.map { |k, v| "&#{k}=#{v}" }.join
    Nokogiri::XML open "http://#{@host}:#{@port}/requests/status.xml?command=#{command}#{params}"
  end
end
