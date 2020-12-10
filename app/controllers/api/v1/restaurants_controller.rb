class Api::V1::RestaurantsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: %i[create update destroy]
  before_action :set_restaurant, only: %i[show update destroy]

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    # render json: { message: "It worked" }
    head :no_content # shows 204 code
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
           status: :unprocessable_entity
  end
end
