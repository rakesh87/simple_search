class CategoriesController < ApplicationController

  def index
    @categories = Category.search_for params[:category_search]
    respond_to do |format|
      format.html
      format.js { render template: 'categories/index.js.erb', :layout => false }
    end
  end

  def autofill_data
    search_param = params[:term]
    categories = Category.where("name like ?", "%#{search_param.strip}%")
    render json: categories.map(&:name)
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def show
    find_category

    respond_to do |format|
      format.html
      format.json { render json: @category }
    end
  end

  def edit
    find_category
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    find_category

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    find_category
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
