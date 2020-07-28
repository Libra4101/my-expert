class Expert::StaticPagesController < Expert::Base
  skip_before_action :authenticate_client!
  def top
  end
end
