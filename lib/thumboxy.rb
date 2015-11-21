require 'sinatra/base'
require 'thumboxy/version'
require 'open-uri'
require 'rmagick'
require 'fileutils'
require 'digest/sha2'

class ThumboxyApp < Sinatra::Base
  # Resize height
  get '/:command/:width/*' do
    command = params[:command]
    width = params[:width]
    remote_url = params[:splat].first
    remote_url.gsub!(/:\//,'://')

    cache_title = "%s:%s:%s" % [command, width, remote_url]
    content_type 'image/jpeg' #fh.content_type

    file_cache(cache_title) do 
      create_thumbnail(command,width,url)
    end
  end

  get '/' do
    'Try /command/width/url instead'
  end

  private

  def create_thumbnail command, width, url
    open(url) do |fh|
      img = Magick::Image.from_blob(fh.read).first
      case command 
      when 'r' then img.resize_to_fit!(width, width)
      when 'c' then img.crop_resized!(width, width, Magick::CenterGravity)
      when 'rh' then img.resize_to_fit!(width, width)
      when 'rw' then img.resize_to_fit!(width, width)
      end
      img.format = 'jpeg' #'png'
      img.to_blob
    end
  end

  def file_cache title
    hash = (Digest::SHA2.new << title).to_s
    cache_file = ENV['HOME'] + '/.thumboxy/' + hash
    result = nil
    if File.exist? cache_file then
      result = File.read cache_file
    else
      result = yield
      File.open(cache_file,'w') do |fh|
        fh.write(result)
      end
    end
    result
  end
end

