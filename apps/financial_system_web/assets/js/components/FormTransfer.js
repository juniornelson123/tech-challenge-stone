import React, { useEffect, useState } from 'react'
import { Formik, Form, Field, FieldArray, ErrorMessage } from 'formik'
import * as Yup from 'yup'
import { getAccounts, createTransfer } from '../services'

function FormTransfer(props) {

  const [accounts, setAccounts] = useState([])

  const fetchAccounts = async () => {
    const response = await getAccounts()
    if(response.ok){
      const arrayAccounts = response.data.filter(item => item.id != props.accountId)
      setAccounts(arrayAccounts)
    }
  }

  useEffect(() => {
    const getData = async () => {
      await fetchAccounts()
    }

    getData()
  }, [])

  return(
    <>
      <div>
        <h1>New Transfer</h1>
        <Formik
          enableReinitialize
          initialValues={{ value: 0, items: [{value: "", account_id: ""}]}}
          onSubmit={async (values, { setSubmitting }) => {
            const response = await createTransfer(props.accountId, values.items)
            
            if(response.ok) {
              if(response.data.success) {
                alert("Transfer Successful")
                window.location.href = props.link
              }else{
                alert(response.data.reason)
              }
            }else{
              alert("Transfer Error")
            }
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
                                type="number"
                                placeholder="account"
                                as="select"
                                name={`items.[${index}].account_id`}
                              >
                                <option value="">Select Account</option>
                                {
                                  accounts.map(item => <option key={item.id} value={item.id}>{item.user.name}</option>)
                                }
                              </Field>
                              <Field
                                type="number"
                                placeholder="value"
                                name={`items.[${index}].value`}
                              />
                              <br />
                              <button
                                type="button"
                                onClick={() =>
                                  arrayHelpers.remove(index)
                                }
                              >Remove</button>
                              <hr />
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