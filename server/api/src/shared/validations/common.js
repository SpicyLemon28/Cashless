import validator from 'validator';
import isEmpty   from 'lodash/isEmpty';

export default function validateInput(data, fields) {
  let errors = {};

  for (let field of fields) {
    if (!data[field]) {
      errors[field] = `Please enter ${field}`;
    } else {
      if (field === 'email') {
        if (!validator.isEmail(data.email))
          errors[field] = 'Invalid email';
      } else if (field === 'cfmPassword') {
        if (data[field] !== data.newPassword)
          errors[field] = 'Not match to Password';
      }
    }
  }

  return { errors, isValid: isEmpty(errors) }
}
