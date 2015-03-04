class PagesController < ApplicationController

  after_action :allow_iframe, only: :weather

  def index
  end
  
  def landing
  end

  def about
  end

  def testing
  end

  def calc
  end

  def weather
  end

private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

end

