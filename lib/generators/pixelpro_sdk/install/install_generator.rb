require 'rails/generators'

module PixelproSdk
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copy PixelproSdk default files'
      source_root ::File.expand_path('../templates', __FILE__)

      class_option :template_engine
      class_option :stylesheet_engine
      class_option :skip_turbolinks, type: :boolean, default: false, desc: "Skip Turbolinks on assets"
      def copy_lib
        directory "lib/templates/#{options[:template_engine]}"
        puts 'test'
      end

      def copy_form_builder
        copy_file "form_builders/form_builder/_form.html.#{options[:template_engine]}", "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}"
      end
    end
  end
end
