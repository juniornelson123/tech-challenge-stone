import React from 'react'
import { Formik, Form, Field, FieldArray, ErrorMessage } from 'formik'
import * as Yup from 'yup'

function FormTransfer(props) {
  return(
    <>
      <div>
        <h1>New Transfer</h1>
        <Formik
          enableReinitialize
          initialValues={{ value: 0, items: []}}
          validationSchema={Yup.object().shape({
            value: Yup.string().required('Required field'),
          })}
          onSubmit={(values, { setSubmitting }) => {
            console.log(values)
          }}
        >
          {({
            values,
            errors,
            touched,
            handleChange,
            handleBlur,
            handleSubmit,
            isSubmitting,
            /* and other goodies */
          }) => (
              <form onSubmit={handleSubmit}>
                <input
                  type="number"
                  name="value"
                  onChange={handleChange}
                  onBlur={handleBlur}
                  value={values.value}
                />
                {errors.value && touched.value && errors.value}

                <FieldArray
                  name="items"
                  render={arrayHelpers => (
                    <React.Fragment>
                      {
                        values.items && values.items.length > 0
                          ? values.items.map((item, index) => (
                            <React.Fragment key={index}>
                              <h6>Account</h6>
                              <Field
                                type="text"
                                placeholder="percent %"
                                name={`items.[${index}].value`}
                              />
                              <Field
                                type="text"
                                placeholder="account"
                                as="select"
                                name={`items.[${index}].account_id`}
                              >
                                <option value="1">Nelson de sousa junior</option>
                                <option value="2">Mariana lima de sousa</option>
                                <option value="3">Jose silva</option>
                              </Field>
                              <br />
                              <button
                                type="button"
                                onClick={() =>
                                  arrayHelpers.remove(index)
                                }
                              >Remove</button>
                            </React.Fragment>
                          ))
                          : false
                          
                      }
                      <br />
                      <button type="button" onClick={() =>
                        arrayHelpers.push({
                          value: '',
                          account_id: ''
                        })
                      }>Add Account</button>
                      <br />
                      <button>Save</button>
                    </React.Fragment>
                  )} 
                />
              </form>
            )}
        </Formik>
      </div>
    </>
  )
}

export default FormTransfer