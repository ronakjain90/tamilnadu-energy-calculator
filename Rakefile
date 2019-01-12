#!/usr/bin/env rake
# coding: utf-8
require 'sprockets'
require 'bootstrap'
require 'haml'
require 'json'
require 'yui/compressor'
require 'uglifier'
require 'rake/sprocketstask'
require 'rake/testtask'

require_relative 'app/models/load_model'
require_relative 'app/helpers/helper'


Rake::SprocketsTask.new do |t|
  sprockets = Sprockets::Environment.new
  sprockets.append_path 'node_modules'
  sprockets.append_path 'app/assets/javascripts'
  sprockets.append_path 'app/assets/stylesheets'
  sprockets.append_path 'app/assets/vendors'

  sprockets.context_class.class_eval do
    include Helper
  end

  sprockets.css_compressor = YUI::CssCompressor.new
  sprockets.js_compressor  = Uglifier.new(mangle: true)

  t.environment = sprockets
  t.output      = "./public/assets"
  t.assets      = %w( application.js application.css )
end

namespace :test do
  desc "Run models tests"
  task :models do
    ruby "test/models/*_test.rb"
  end

  desc "Run routes tests"
  task :controllers do
    ruby "test/controllers/*_test.rb"
  end

  desc "Run acceptance tests"
  task :acceptance do
    ruby "test/acceptance/*_test.rb"
  end

  task :all => [:models, :controllers, :acceptance]
end

namespace :asset do

  task :clean do
    `rm -rf public/assets/application**`
    `rm -rf public/assets/.sprockets-manifest**`
  end

  task :rename_manifest do
    `mv public/assets/.sprockets-manifest** public/assets/manifest.json`
  end

  manifest = './public/assets/manifest.json'
  file manifest => ['assets']

  desc "Compiles changes to app/views/default.html.haml into public/default.html and adds links it to the latest versions of application.cs and application.js"
  task :html => [manifest] do

    class Context
      include Helper
    end

    context = Context.new

    # We need to figure out the filename of the latest javascript and css
    context.assets = JSON.parse(IO.readlines(manifest).join)['assets']

    input = IO.readlines('./app/views/default.html.haml').join
    File.open('./public/default.html','w') do |f|
      f.puts Haml::Engine.new(input).render(context)
    end
  end

  task :pipeline => [:clean, :assets, :rename_manifest, 'asset:html' ]
end