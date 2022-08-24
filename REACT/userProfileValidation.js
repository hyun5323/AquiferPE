import * as Yup from 'yup';

const userProfileValidation = Yup.object().shape({
    firstName: Yup.string().min(2).max(100).required('First Name is Required'),
    lastName: Yup.string().min(2).max(100).required('Last Name is Required'),
    mi: Yup.string(0).min(1),
    locationId: Yup.number().required('Location is Required'),
    avatarUrl: Yup.string().min(3).max(255),
    professionTypeId: Yup.array().required('Profession Type is Required'),
    dOB: Yup.string().required('Date of Birth is Required'),
    email: Yup.string().min(5).max(100).required('Email is Required'),
    phone: Yup.string().min(5).max(20).required('Your Phone Number is Required'),
    licenseNumber: Yup.string(2).min(3).max(50).required('License Number is Required'),
    yearsOfExperience: Yup.string().min(1).max(10).required('Your Years of Experience is Required'),
    desiredHourlyRate: Yup.string().min(1).max(10).required('Desired Hourly Rate is Required'),
    isActive: Yup.string().min(3).max(50).required('You Must Select A Field'),
});

export default userProfileValidation;
