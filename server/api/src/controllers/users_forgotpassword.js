import jwt from 'jsonwebtoken';
import User from '../models/User';

import validateInput from '../shared/validations/common';
import { sendResetPasswordEmail, sendConfirmedResetPasswordEmail } from '../mailer';

export default {
  requestResetPassword: (req, res) => {
    const { phone } = req.body;
    const { errors, isValid } = validateInput({ phone }, ['phone']);

    const userRequestResetPassword = (phone) => {
      User.where({ phone: phone }).fetch().then(user => {
        if (user && user.isConfirmed()) {
          const jsonUser = { email: user.get('email'), name: user.get('name'), confirmationCode: user.generateConfirmationCode() };
          sendResetPasswordEmail(jsonUser);
          res.json({ result: 1, description: 'request reset password' });
        } else {
          res.status(400).json({ error: 'Phone number not yet confirm' });
        }
      }).catch(
        err => res.status(500).json({ error: 'Phone number not found' })
      );
    };

    isValid ? userRequestResetPassword(phone) : res.status(400).json(errors);
  },

  confirmedRequestResetPassword: (req, res) => {
    const { confirmationCode } = req.body;
    User.where({ reset_password_confirmation_code: confirmationCode }).fetch().then(user => {
      user.save({ reset_password_confirmed: 1 }).then(() => {
        res.json({ result: 2, description: 'confirmed request reset password', token: user.get('reset_password_token') })
      });
    }).catch(
      err => res.status(500).json({ error: 'Invalid confirmation code' })
    );
  },

  resetPassword: (req, res) => {
    const { token, newPassword, cfmPassword } = req.body;
    const { errors, isValid } = validateInput(
      {newPassword, cfmPassword}, ['newPassword', 'cfmPassword']
    );

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
      if (err) {
        res.status(401).json({ error: "Reset password process expired, please reprocess again." })
      } else {
        const userResetPassword = (newPassword) => {
          new User({id: decoded.id}).fetch().then(user =>  {
            if (user) {
              user.save({ password: newPassword, reset_password_completed: 1 })
                .then(() => res.json({ result: 3, description: 'reset password reset_password_completed' }) );
            } else {
              res.status(401).json({ error: "Reset password process expired, please reprocess again." });
            }
          });
        };

        isValid ? userResetPassword(newPassword) : res.status(400).json(errors);
      }
    });
  },

}
