class Admin::StaticPagesController < Admin::Base
  def top
    @clients_data = Client.group("TO_CHAR(created_at, 'yyyy/mm')").select("TO_CHAR(created_at, 'yyyy/mm') as month, sum(count(*)) OVER(ORDER BY TO_CHAR(created_at, 'yyyy/mm') ASC) as cnt").order("month ASC")
    @experts_data = Expert.group("TO_CHAR(created_at, 'yyyy/mm')").select("TO_CHAR(created_at, 'yyyy/mm') as month, sum(count(*)) OVER(ORDER BY TO_CHAR(created_at, 'yyyy/mm') ASC) as cnt").order("month ASC")
    gon.latitude = @expert.office.latitude
    gon.longitude = @expert.office.longitude
  end
end
