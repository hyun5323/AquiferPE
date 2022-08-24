import { lazy } from 'react';
const PageNotFound = lazy(() => import('../pages/error/PageNotFound'));
const UserProfile = lazy(() => import('../components/userprofile/UserProfile'));
const UserProfileForm = lazy(() => import('../components/userprofile/UserProfileForm'));

const errorRoutes = [
    {
        path: '*',
        name: 'Error - 404',
        element: PageNotFound,
        roles: [],
        exact: true,
        isAnonymous: false,
    },
];

const userProfile = [
        {
            path: '/userprofile',
            name: 'UserProfile',
            element: UserProfile,
            roles: ['Admin', 'User'],
            exact: true,
            children: [      
                {                    
                    path: '/userprofile/edit',
                    name: 'UserProfileForm',
                    exact: true,
                    element: UserProfileForm,
                    roles: ['User', 'Admin'],
                    isAnonymous: true,               
                } 
            ]
        }    
    ];

const allRoutes = [
    ...errorRoutes,
    ...userProfile,
];

export default allRoutes;
