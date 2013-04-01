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
end