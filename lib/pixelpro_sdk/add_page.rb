require "thor"

module PixelproSdk
  # add or edit files to the rails project
  class AddPage < Thor::Group
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    # Add controller files to the rails project<br>
    # config_ui for the ui page for configration<br>
    # ins for install the pixel app<br>
    # info for display dll<br>
    # event for response pixel pro action event(optional)<br>
    def add_controller_file name
      create_file "app/controller/#{name}_controller.rb" do
        "class CarRestrictionController < ApplicationController\n
          skip_before_action :verify_authenticity_token\n
          def config_ui
            # Add your codes here
          end

          def ins
            # Add your codes here
          end

          def info
            # Add your codes here
          end

          def event
            # Add your codes here
          end\nend\n"
      end
    end

    # Append route to the config/routes file
    def append_route name
      if (::File.exist? "config/routes.rb")
        append_to_file "config/routes.rb" do
          "Rails.application.routes.draw do
            get 'info' => '#{name}#info'
            get 'event' => '#{name}#event'
            get 'config' => '#{name}#config_ui'
            post 'ins' => '#{name}#ins'
          end\n"
        end
      else
        raise "No Routes File Found"
      end
    end

    def add_migrate_file
      execute :bundle, "rails generate migration CreatePixel pixel_uid:string user_id:integer"
    end

  end
end