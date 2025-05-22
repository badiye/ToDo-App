class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :track_visit

  private

  def track_visit
    #total visit count
    session[:visit_count] ||= 0
    session[:visit_count] += 1
    @visit_count = session[:visit_count]

    #visit count per specific page
    session[:page_visit] ||= {}
    path = request.path
    session[:page_visit][path] ||=0
    session[:page_visit][path] += 1
    @page_visit = session[:page_visit][path]

    #last visit in minutes
    session[:last_visited] = Time.current
  end
end
