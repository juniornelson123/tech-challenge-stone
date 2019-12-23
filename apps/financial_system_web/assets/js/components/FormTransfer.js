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
    <div class="flex flex-col">
      <span class="text-2xl">New Transfer</span>
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
                            <div class="mt-6">
                              <h6 className="text-gray-600">Account</h6>
                              <Field
                                type="number"
                                placeholder="account"
                                as="select"
                                className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal"
                                name={`items.[${index}].account_id`}
                              >
                                <option value="">Select Account</option>
                                {
                                  accounts.map(item => <option key={item.id} value={item.id}>{item.user.name}</option>)
                                }
                              </Field>
                            </div>
                            <div class="mt-6">
                              <label className="text-gray-600">Value</label>
                              <Field
                                type="number"
                                placeholder="value"
                                className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-full appearance-none leading-normal"
                                name={`items.[${index}].value`}
                              />
                            </div>
                            <br />
                            <button
                              className="bg-red-500 rounded text-white shadow p-2 w-1/12 text-center mr-4 mb-8"
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
                    } className="bg-blue-500 rounded text-white shadow p-2 w-2/12 text-center mr-4 mb-8" >Add Account</button>
                    <br />
                    <div>
                      <a href={`/accounts/${props.accountId}/transfers`} className="bg-red-500 rounded text-white shadow p-3 w-1/12 text-center mr-4">Cancel</a>
                      <button className="bg-green-500 rounded text-white shadow p-2 w-1/12 text-center mr-4">Save</button>

                    </div>
                  </React.Fragment>
                )} 
              />
            </form>
          )}
      </Formik>
    </div>
  )
}

export default FormTransfer