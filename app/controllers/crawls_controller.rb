class CrawlsController < ApplicationController
  def home
    @bars = Bar.all
    @crawls = Crawl.all
  end

  def index
  end

  def new
  end

  def create
  end
end
