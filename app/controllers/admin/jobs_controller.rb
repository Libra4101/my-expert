class Admin::JobsController < Admin::Base
  before_action :set_job, only: %i[update destroy]

  def index
    @jobs = Job.page(params[:page]).per(10)
    @job = Job.new
  end

  def create
    @job = Job.new(job_param)
    if @job.save
      flash[:success] = t('success.create', data: @job.title)
      redirect_to admin_jobs_url
    else
      @jobs = Job.page(params[:page]).per(10)
      flash.now[:error] = t('error.validate_error')
      render :index
    end
  end

  def update
    if @job.update(job_param)
      flash[:success] = t("success.update", data: @job.title)
      redirect_to admin_jobs_url
    else
      @jobs = Job.page(params[:page]).per(10)
      flash.now[:error] = t("error.validate_error")
      render :index
    end
  end
  
  def destroy
    if @job.destroy
      flash[:success] = t("success.delete", data: @job.title)
      redirect_to admin_jobs_url
    else
      flash[:error] = t("error.delete_error")
      redirect_to admin_jobs_url
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  # ストラングパラメーター
  def job_param
    params.require(:job)
      .permit(:title, :content)
  end
end
