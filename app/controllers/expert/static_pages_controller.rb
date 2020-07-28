class Expert::StaticPagesController < Expert::Base
  skip_before_action :authenticate_expert!
  def top
  end
end
