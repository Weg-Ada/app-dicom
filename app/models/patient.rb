# vim: set sw=2 ts=2 ai noet :
class Patient < ApplicationRecord
	has_secure_password
	has_many :examinations

	def self.load_data
		require 'find'
		files = []
		dirs = DICOM_PATH

		dirs.each do |dir|
			Examination.create_from_dir(dir)
		end

		files.each do |file|
			dcm = DICOM::DObject.read(file)
			if dcm.read?
				patient_name = dcm.patients_name.value
				patient = Patient.find_by_name(patient_name)
				patient ||= Patient.create(name: patient_name, login: patient_name, password: 'qwerty', is_admin: false)

				examination = Examination.create_with_path(file)
			end
		end
	end
end