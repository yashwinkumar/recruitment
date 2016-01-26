class TemplatesController < ApplicationController

  before_action :set_template, only: [:show, :edit, :update, :destroy]
  layout "dashboard"

  def index
    @templates = current_user.templates
  end

  def show
    @sections = @template.sections
  end

  def new
    @template = current_user.templates.new
  end

  def edit
  end

  def create
    @template = current_user.templates.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to @template, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_more_sections

  end

  private
  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:name, {:sections_attributes => [:name, :id, :_destroy]})
  end
end
