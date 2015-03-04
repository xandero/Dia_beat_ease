class PagesController < ApplicationController

  after_action :allow_iframe, only: :embed

  def embed
  end

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

private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

end

