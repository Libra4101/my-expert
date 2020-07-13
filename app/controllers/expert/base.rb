class Expert::Base < ApplicationController
  layout 'expert/expert'
  before_action :authenticate_expert!
end