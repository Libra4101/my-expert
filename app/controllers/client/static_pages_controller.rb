class Client::StaticPagesController < Client::Base
  skip_before_action :authenticate_client!
  def top
  end

  def about
  end
end
