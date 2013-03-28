class CareersController < ApplicationController

def show
  @career = Career.find(params[:id])
end

end