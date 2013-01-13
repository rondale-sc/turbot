# Author: Robert Jackson (robert.w.jackson@me.com)
# Inspired by epitron/pookie: https://github.com/epitron/pookie/blob/master/handlers/url_handler.rb

require_relative 'url_handler/common'
require_relative 'url_handler/github_repo_handler'
require_relative 'url_handler/gist_handler'
require_relative 'url_handler/twitter_user_handler'
require_relative 'url_handler/twitter_status_handler'
require_relative 'url_handler/youtube_handler'
require_relative 'url_handler/image_handler'
require_relative 'url_handler/generic_handler'

module TurbotPlugins::UrlHandler
  class Processor
    include Cinch::Plugin

    listen_to :channel

    def handlers
      Handlers.handlers
    end

    def listen(m)
      URI.extract(m.raw, ['http','https']).each do |url|
        handler = handlers.find{|h| h.match?(url)}

        m.reply handler.new(url).info
      end
    end
  end
end
