import React, { useEffect, useState } from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import userProfilesService from '../../services/userProfilesService';
import userProfileValidation from '../../schema/userprofile/userProfileValidation';
import { Row, Col, Container } from 'react-bootstrap';
import * as toastr from 'toastr';
import Swal from 'sweetalert2';
import debug from 'sabio-debug';
import PropTypes from 'prop-types';
import { useNavigate, useLocation } from 'react-router-dom';

const UserProfileForm = (props) => {
    const _logger = debug.extend('UserProfile');
    const _loggerPage = _logger.extend('UserProfileForm');
    const navigate = useNavigate();
    const { state } = useLocation();
    const locationValues = state.payload;

    _logger('useLocation', { state });
    _loggerPage('props current user', props.currentUser.id);

    const [aUserProfileData, setAUserProfileData] = useState({
        firstName: '',
        lastName: '',
        mi: '',
        location: '',
        avatarUrl: '',
        profession: [],
        dob: '',
        email: '',
        phone: '',
        licenseNumber: '',
        yearsOfExperience: 0,
        desiredHourlyRate: '',
        isActive: '',
    });

    const aUserProfile = props.currentUser;
    _loggerPage('aUserProfile Props:', aUserProfile);

    useEffect(() => {
        _loggerPage('useEffect is firing');

        userProfilesService.getCurrentUserProfile().then(onGetCurrentUserSuccess).catch(onGetCurrentUserError);
    }, []);

    const onGetCurrentUserSuccess = (response) => {
        _loggerPage('onGetCurrentUserSuccess', response);

        setAUserProfileData(() => {
            const aUserProfileData = response;
            return aUserProfileData;
        });
    };

    const onGetCurrentUserError = (err) => {
        _loggerPage('onGetCurrentUserError', err);
        toastr.error('Unable to register profile');
    };

    const handleSubmit = (values) => {
        let payload = values;
        Swal.fire({
            title: !aUserProfileData.id ? 'Please Confirm Registration' : 'Please Confirm Update',
            icon: 'Alert',
            showCancelButton: true,
            confirmButtonText: 'Confirm',
        }).then((result) => {
            if (result.isConfirmed) {
                if (!aUserProfileData.id) {
                    userProfilesService.profileRegister(payload).then(onAddProfileSuccess).catch(onAddProfileError);
                } else {
                    userProfilesService
                        .updateById(payload, aUserProfileData.id)
                        .then(onEditProfileSuccess)
                        .catch(onEditProfileError);
                }
            }
        });
    };

    _loggerPage('handleSubmit', handleSubmit);

    const onAddProfileSuccess = (response) => {
        _loggerPage('onAddProfileSuccess', response);
        setAUserProfileData((prevState) => {
            const newProfileObject = {
                ...prevState,
            };
            newProfileObject.id = response.id;
            return newProfileObject;
        });
        toastr.success('User Profile has been successfully added');
        Swal.fire('Your profile has been registered.');
        const stateForSendingProfileData = {
            type: 'Userprofile Data',
            payload: aUserProfileData,
        };
        navigate(`/userprofile`, { state: stateForSendingProfileData });
    };

    const onAddProfileError = (err) => {
        _loggerPage('onAddProfileError', err);
        toastr.error('Failed to Register Profile');
    };

    const onEditProfileSuccess = (response) => {
        _loggerPage('onEditProfileSuccess', response);
        toastr.success('User Profile has been successfully updated');
        Swal.fire('Your profile has been updated.');
        const stateForSendingProfileData = {
            type: 'Userprofile Data',
            payload: aUserProfileData,
        };
        navigate(`/userprofile`, { state: stateForSendingProfileData });
    };

    const onEditProfileError = (err) => {
        _loggerPage('onEditProfileError', err);
        toastr.error('Failed to update profile');
    };

    const handlePreview = (event) => {
        _logger('preview showing', event);
        const { name, value } = event.target;
        setAUserProfileData((prev) => ({
            ...prev,
            [name]: value,
        }));
    };

    return (
        <React.Fragment>
            <Container>
                <Row>
                    <h1 className="form-title">Edit Your Profile</h1>
                    <Col>
                        <Container fluid style={{ maxWidth: '600px', textAlign: 'center' }}>
                            <Row className="row d-flex justify-content-center">
                                <Col className="col-md-12 bg-light border rounded-3 p-3">
                                    <Formik
                                        enableReinitialize={true}
                                        initialValues={locationValues}
                                        onSubmit={handleSubmit}
                                        validationSchema={userProfileValidation}>
                                        {({ values }) => (
                                            <Form className="mt-4">
                                                <div className="form-group">
                                                    <label htmlFor="fname">First Name</label>
                                                    <Field
                                                        type="text"
                                                        name="fname"
                                                        className="form-control"
                                                        value={values.firstName}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage
                                                        name="fname"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="lname">Last Name</label>
                                                    <Field
                                                        type="text"
                                                        name="name"
                                                        className="form-control"
                                                        value={values.lastName}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage
                                                        name="lname"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="mi">Middle Initial</label>
                                                    <Field
                                                        type="text"
                                                        name="mi"
                                                        className="form-control"
                                                        value={values.mi}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage name="mi" component="div" className="text-danger" />
                                                </div>
                                                <div className="d-none">
                                                    <label htmlFor="email">Email</label>
                                                    <Field
                                                        type="email"
                                                        name="email"
                                                        className="form-control"
                                                        value={values.email}
                                                    />
                                                    <ErrorMessage
                                                        name="email"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="dob">Date of Birth</label>
                                                    <Field
                                                        type="text"
                                                        name="dob"
                                                        className="form-control"
                                                        value={values.dob.substring(0, 10)}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage name="dob" component="div" className="text-danger" />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="email">Email</label>
                                                    <Field
                                                        type="text"
                                                        name="email"
                                                        className="form-control"
                                                        value={values.email}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage
                                                        name="email"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="phone">Phone Number</label>
                                                    <Field
                                                        type="text"
                                                        name="phone"
                                                        className="form-control"
                                                        value={values.phone}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage
                                                        name="phone"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="name">License Number</label>
                                                    <Field
                                                        type="text"
                                                        name="name"
                                                        className="form-control"
                                                        value={values.licenseNumber}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage name="name" component="div" className="text-danger" />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="yoe">Years of Experience</label>
                                                    <Field
                                                        type="text"
                                                        name="yoe"
                                                        className="form-control"
                                                        value={values.yearsOfExperience}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage name="yoe" component="div" className="text-danger" />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="dhr">Desired Hourly Rate</label>
                                                    <Field
                                                        type="text"
                                                        name="dhr"
                                                        className="form-control"
                                                        value={values.desiredHourlyRate}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage name="dhr" component="div" className="text-danger" />
                                                </div>
                                                <div className="form-group">
                                                    <label htmlFor="dhr">Profile Picture Url</label>
                                                    <Field
                                                        type="text"
                                                        name="pic-url"
                                                        className="form-control"
                                                        value={values.avatarUrl}
                                                        onKeyUp={handlePreview}
                                                    />
                                                    <ErrorMessage
                                                        name="pic-url"
                                                        component="div"
                                                        className="text-danger"
                                                    />
                                                </div>
                                                <Row
                                                    style={{ marginBottom: '18px' }}
                                                    className="justify-content-center">
                                                    {' '}
                                                    <button
                                                        type="submit"
                                                        className="btn btn-light"
                                                        style={{ marginTop: 'flex' }}>
                                                        {!aUserProfileData.id ? 'Add' : 'Update'}
                                                    </button>
                                                </Row>
                                            </Form>
                                        )}
                                    </Formik>
                                </Col>
                            </Row>
                        </Container>
                    </Col>
                </Row>
            </Container>
        </React.Fragment>
    );
};

UserProfileForm.propTypes = {
    currentUser: PropTypes.shape({
        email: PropTypes.string.isRequired,
        id: PropTypes.number.isRequired,
        isLoggedIn: PropTypes.bool.isRequired,
        roles: PropTypes.arrayOf(PropTypes.string).isRequired,
    }),
};

export default UserProfileForm;
