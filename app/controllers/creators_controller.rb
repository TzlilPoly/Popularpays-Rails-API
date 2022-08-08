class CreatorsController < ApplicationController
  before_action :restrict_creator_access
  before_action :set_creator, only: [:show, :update, :destroy]

  # GET /creators ,query params:  sort, sort_direction, limit and offset
  # The sort param determines which attribute of creator to sort by.
  # The sort_direction param should accept either asc or desc
  # The offset param defines how many records to skip in the results set. E.G. if limit was 5 and offset was 5 this would return records 6 through 10.
  def index
    @creators = Creator.all

    sort_by_param = params[:sort] ? params[:sort] : nil
    sort_direction_param = params[:sort_direction] ? params[:sort_direction] : nil
    limit_param = params[:limit] ? params[:limit] : nil
    offset_param = params[:offset] ? params[:offset] : nil

    render json: @creators.offset(offset_param).limit(limit_param).order("#{sort_by_param} #{sort_direction_param}" )
  end

  # GET /creators/1
  def show
    render json: @creator
  end

  # POST /creators
  def create
    @creator = Creator.new(creator_params)

    if @creator.save
      render json: @creator, status: :created, location: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /creators/1
  def update
    if @creator.update(creator_params)
      render json: @creator
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  # DELETE /creators/1
  def destroy
    @creator.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_creator
    @creator = Creator.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def creator_params
    params.require(:creator).permit(:first_name, :last_name)
  end

  def restrict_creator_access
    if !@api_key.creator_access
      render json: {error: "Authorization failed"}, status: :network_authentication_required
    end
  end
end
