# vim: set sw=2 ts=2 ai noet :
class ExaminationsController < ApplicationController
	before_action :set_examination, only: [:show, :image, :edit, :update, :destroy]
	before_action :verify_admin, except: [:index, :show, :image]
	
	# GET /examinations
	# GET /examinations.json
	def index
		if current_user
			if current_user.is_admin
				@examinations = Examination.all
			else
				@examinations = current_user.examinations
			end
		else
			@examinations = []
		end
	end

	# GET /examinations/1
	# GET /examinations/1.json
	def show
		return unless (@examination.patient.id == current_user.id) || current_user.is_admin
		@dicom = @examination.dicom
	end

	def image
		image = @examination.full_dicom.image.normalize
		image.format = 'png'
		blob = image.to_blob
		filename = "#{@examination.name}_#{@examination.examinated_at}.png"
		filename.gsub!(/\s/, "_")
		send_data blob, :type => 'image/png', :disposition => params[:disp], :filename => filename
	end

	# GET /examinations/new
	def new
		@examination = Examination.new
	end

	# GET /examinations/1/edit
	def edit
	end

	# POST /examinations
	# POST /examinations.json
	def create
		@examinations = Examination.create_from_dir(params[:examination][:path])

		respond_to do |format|
			flash[:success] = "Examination was successfully created."
			format.html { render :index }
			format.json { render :show, status: :created, location: @examination }
		end
	end

	# PATCH/PUT /examinations/1
	# PATCH/PUT /examinations/1.json
	def update
		respond_to do |format|
			if @examination.update(examination_params)
				flash[:info] = "Examination was successfully updated."
				format.html { redirect_to @examination }
				format.json { render :show, status: :ok, location: @examination }
			else
				format.html { render :edit }
				format.json { render json: @examination.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /examinations/1
	# DELETE /examinations/1.json
	def destroy
		@examination.destroy
		respond_to do |format|
			flash[:warning] = "Examination was successfully destroyed."
			format.html { redirect_to examinations_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_examination
			@examination = Examination.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def examination_params
			params.require(:examination).permit(:name, :path, :examinated_at, :patient_id)
		end
end