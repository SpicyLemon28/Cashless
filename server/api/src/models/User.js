import bookshelf from '../bookshelf';
import jwt from 'jsonwebtoken';

import UserLoadDetail from './UserLoadDetail';
import UserPayDetail from './UserPayDetail';
import UserLoadTransferDetail from './UserLoadTransferDetail';

const { HOST, JWT_SECRET } = process.env;

export default bookshelf.Model.extend({
  tableName: 'users',

  loadDetail: function() {
    return this.hasMany('UserLoadDetail')
  },

  payDetail: function() {
    return this.hasMany('UserPayDetail')
  },

  loadTransferDetail: function() {
    return this.hasMany('UserLoadTransferDetail')
  },

  isPasswordMatch: function(password) {
    return password === this.get('password');
  },

  isConfirmed: function() {
    return this.get('confirm')
  },

  isResetPasswordConfirmed: function() {
    return this.get('reset_password_confirmed')
  },

  isResetPasswordCompleted: function() {
    return this.get('reset_password_completed')
  },

  generateResetPasswordToken: function() {
    const token = jwt.sign({id: this.get('id')}, JWT_SECRET, {expiresIn: "3m"});
    this.set('reset_password_token', token);
    this.set('reset_password_confirmed', 0);
    this.set('reset_password_completed', 0);
    this.save();
    return token;
  },

  generateConfirmationCode: function() {
    const token = this.generateResetPasswordToken();
    const confirmationCode = token.slice(token.length-8);
    this.set('reset_password_confirmation_code', confirmationCode);
    this.save();
    return confirmationCode;
  },

});
