import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useNavigate } from 'react-router-dom';
import debug from 'sabio-debug';
import userProfilesService from '../../services/userProfilesService';
import * as toastr from 'toastr';
import './profile.css';

const _loggerPage = debug.extend('UserProfile');

function UserProfile(props) {
    _loggerPage('UserProfile', props);
    const navigate = useNavigate();

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

    const professionObject = aUserProfileData.profession[0];
    _loggerPage('professionObject', professionObject);

    useEffect(() => {
        _loggerPage('useEffect is firing');
        userProfilesService
            .getCurrentUserProfile(props.currentUser.id)
            .then(onGetCurrentUserSuccess)
            .catch(onGetCurrentUserError);
    }, []);

    _loggerPage('props current user', props.currentUser.id);

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

    const onClickToEditProfile = (e) => {
        _loggerPage('navigate to edit the profile', e.currentTarget);
        const stateForSendingProfileData = { type: 'USERPROFILE_VIEW', payload: aUserProfileData };
        navigate(`/userprofile/edit`, { state: stateForSendingProfileData });
    };

    const onClickTofollowers = (e) => {
        _loggerPage('navigate to edit the profile', e.currentTarget);
        // const stateForSendingProfileData = { type: 'USERPROFILE_VIEW', payload: aUserProfileData };
        navigate(`/followers`);
    };

    return (
        <React.Fragment>
            <section className="section-aquifer about-section gray-bg">
                <div className="container">
                    <div className="row align-items-center flex-row-reverse">
                        <div className="col-lg-6">
                            <div className="about-text go-to">
                                <h3 className="dark-color">Welcome To My Profile!</h3>
                                <h6 className="theme-color lead">
                                    A Project Manager based in {aUserProfileData.location.city}, Arizona
                                </h6>
                                <span>
                                    Welcome to my Profile. My name is {aUserProfileData.firstName}. I specialize in
                                    overseeing contruction sites and managing workers and logistics. My dream is to
                                    build the tallest skyscraper!
                                </span>
                                <div className="row about-list">
                                    <div className="col-md-6">
                                        <div className="select-form-profile">
                                            <label>First Name</label>
                                            <span>{aUserProfileData.firstName}</span>
                                        </div>
                                        <div className="select-form-profile">
                                            <label>Last Name</label>
                                            <span>{aUserProfileData.lastName}</span>
                                        </div>
                                        <div className="select-form-profile">
                                            <label>Location</label>
                                            <span>{aUserProfileData.location.city}</span>
                                        </div>
                                        <div className="select-form-profile">
                                            <label>Email</label>
                                            <span>{aUserProfileData.email}</span>
                                        </div>
                                    </div>
                                    <div className="col-md-6">
                                        <div className="select-form-profile">
                                            <label>Phone</label>
                                            <span>{aUserProfileData.phone}</span>
                                        </div>
                                        <div className="select-form-profile">
                                            <label>DOB</label>
                                            <span>{aUserProfileData.dob.substring(0, 10)}</span>
                                        </div>
                                        <div className="mediaa">
                                            <label>Years of Experience</label>
                                            <span>
                                                {aUserProfileData.yearsOfExperience} {'Years'}
                                            </span>
                                        </div>
                                        <div className="mediaa">
                                            <label>Desired Hourly Rate</label>
                                            <span>
                                                {'$'}
                                                {aUserProfileData.desiredHourlyRate}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="col-lg-6">
                            <div className="about-avatar round-circle">
                                <img src={aUserProfileData.avatarUrl} title="" alt="" />
                            </div>
                        </div>
                        <div className="userprofile-buttons-to-edit pt-2">
                            <button
                                className="btn btn-secondary edit-profile-button"
                                type="button"
                                id="edit-profile-btn"
                                name="edit-profile-btn"
                                onClick={onClickToEditProfile}>
                                Edit Profile
                            </button>
                        </div>
                        <div className="follwers-button pt-2">
                            <button
                                className="btn btn-secondary follower-button"
                                type="button"
                                id="follower-btn"
                                name="follower-btn"
                                onClick={onClickTofollowers}>
                                Followers
                            </button>
                        </div>
                    </div>
                </div>
            </section>
        </React.Fragment>
    );
}

UserProfile.propTypes = {
    currentUser: PropTypes.shape({
        email: PropTypes.string.isRequired,
        id: PropTypes.number.isRequired,
        isLoggedIn: PropTypes.bool.isRequired,
        roles: PropTypes.arrayOf(PropTypes.string).isRequired,
    }),
};

export default UserProfile;
