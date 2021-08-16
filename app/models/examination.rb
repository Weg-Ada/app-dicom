# vim: set sw=2 ts=2 ai noet :
class Examination < ApplicationRecord
  belongs_to :patient

	def dicom
		dcm = DICOM::DObject.read(path)
		gender = dcm.value("0010,0040")
		age = dcm.value("0010,1010")
		age = age.gsub(/\D/,'').to_i

		{
			gender: gender,
			age: age,
		}
	end

	def full_dicom
		DICOM::DObject.read(path)
	end

	def self.create_with_path(path)
		dcm = DICOM::DObject.read(path)
		examinations = nil
		if dcm.read?
			patient_name = dcm.patients_name.value
			patient = Patient.find_by_name(patient_name)
			patient ||= Patient.create(name: patient_name, login: patient_name, password: 'qwerty', is_admin: false)
			eat =	dcm.value('0008,0020')
			name = dcm.value('0008,1030') || "#{eat}_#{patient_name}"
			eat = Date.strptime(eat, '%Y%m%d')
			examination = Examination.first_or_create(patient_id: patient.id, path: path, name: name, examinated_at: eat) do |ex|
				ex.save!
			end
		end
		examination
	end
	
	def self.create_from_dir(dir)
		require 'find'
		files = []
		@examinations = []
		
		Find.find(dir) do |path|
			if FileTest.directory?(path)
				next
			else
				files << path
			end
		end
	
		files.each do |file|
			@examinations << self.create_with_path(file)
		end
	end
end