class JobsController < ApplicationController
  before_filter :logged_in

  def search_jobs
    Job.search(@auth,Career.find(params[:id]))
  end

  def add
    job = Job.new
    job.transform_to_job( params[:url] )
    @auth.jobs << job
  end

  def destroy
    @auth.jobs -= [Job.find(params[:id])]
    @auth.save
  end

  def import
    if params[:url].include?("authenticjobs.com/jobs/")
      new_job = Job.new
      new_job.add_from_authentic_jobs(params[:url])
      @auth.tanks.first.jobs << new_job
    end
    if params[:url].include?("idealist.org")
      new_job = Job.new
      new_job.add_from_idealist(params[:url])
      @auth.tanks.first.jobs << new_job
    end
    if params[:url].include?("indeed.com")
      new_job = Job.new
      new_job.add_from_indeed(params[:url])
      @auth.tanks.first.jobs << new_job
    end
    if params[:url].include?("jobs.37signals.com/jobs")
      new_job = Job.new
      new_job.add_from_37signals(params[:url])
      @auth.tanks.first.jobs << new_job
    end
    render nothing: true
  end
end