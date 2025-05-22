class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :track_visit
  before_action :set_greeting
  
  private
  
  def track_visit
    # Initialize session if it's a new session
    session[:first_visit] ||= Time.current
    
    # Initialize or increment page-specific visit counter
    session[:page_visits] ||= {}
    session[:page_visits][request.path] ||= 0
    session[:page_visits][request.path] += 1
    
    # Set instance variables for the view
    @visit_count = session[:page_visits][request.path]
    @total_visits = session[:page_visits].values.sum
  end
  
  def set_greeting
    current_hour = Time.current.hour
    @greeting = if current_hour < 12
                  'Good Morning'
                elsif current_hour < 18
                  'Good Afternoon'
                else
                  'Good Evening'
                end
  end
end
