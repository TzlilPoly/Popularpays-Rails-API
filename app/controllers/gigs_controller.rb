class GigsController < ApplicationController
  before_action :restrict_gig_access
  before_action :set_gig, only: [:show, :update, :destroy]

  # GET /gigs
  def index
    brand_name_param = params[:brand_name] ? params[:brand_name] : nil
    creator_id_param = params[:creator_id] ? params[:creator_id] : nil
    if brand_name_param or creator_id_param
      # @gigs = Gig.where("brand_name = ? OR creator_id = ?", brand_name_param, creator_id_param)
      @gigs = Gig.where({ brand_name: brand_name_param, creator_id: creator_id_param})
      render json: @gigs
    else
      @gigs = Gig.all
      render json: @gigs
    end

  end
  def to_boolean(str)
    str == 'true'
  end
  def clear_array_items(array)
    array.delete("id")
    array.delete("created_at")
    array.delete("updated_at")
    return array
  end
  # GET /gigs/1
  def show
    include_param = params[:include] ? params[:include] : nil
    gig_keys = clear_array_items(Gig.new.attributes.keys)

    if include_param == "gig"
      render json: @gig, fields: {'gig': gig_keys}
    elsif include_param == "creator"
      creator_keys = clear_array_items(Creator.new.attributes.keys)
      creator_class_name = Creator.new.class.name.downcase
      render json: @gig, fields: {'gig': gig_keys, 'creator': creator_keys}, include: [creator_class_name]
    elsif include_param == "gig_payment"
      gig_payment_keys = clear_array_items(GigPayment.new.attributes.keys)
      render json: @gig, fields: {'gig': gig_keys, 'gig_payment': gig_payment_keys}, include: ['gig_payment']
    else
      render json: @gig
    end
  end

  # POST /gigs
  def create
    @gigs = Gig.new(gig_params)

    if @gigs.save
      render json: @gigs, status: :created, location: @gigs
    else
      render json: @gigs.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gigs/1
  def update
    if gig_params[:state] == "completed"
      if gig_params[:creator_id]
        if Creator.find_by(id: gig_params[:creator_id])
          @gig.complete!
        end
      else
          @gig.complete!
      end
    end


    if @gig.update(gig_params)
      render json: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gigs/1
  def destroy
    @gig.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gig
    @gig = Gig.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  # require must be in payload
  # permit clear from the request all attr that not appear inside the brackets
  def gig_params
    params.require(:gig).permit(:brand_name, :creator_id, :state)
  end

  def restrict_gig_access
    if !@api_key.gig_access
      render json: {error: "Authorization failed"}, status: :network_authentication_required
    end
  end
end
