import React, { useState } from 'react'
import { Formik, Field } from 'formik'
import { exchange } from '../services'

function FormExchange(props) {
  const [valueTo, setValueTo] = useState(0)

  return(
    <div class="flex flex-col">
      <span class="text-2xl">Exchange</span>
      <Formik
        enableReinitialize
        initialValues={{ value_from: "", value_to: "", currency_from: "BRL", currency_to: "USD" }}
        onSubmit={async (values, { setSubmitting }) => {
          const response = await exchange(values.currency_from, values.currency_to, values.value_from)
          if(response.ok) {
            setValueTo(response.data)
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
              <div class="mt-6 flex">
                <Field
                  type="number"
                  className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-1/4 mr-8 appearance-none leading-normal"
                  placeholder="Value From"
                  name={`value_from`}
                />
                <Field
                  type="text"
                  className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-3/4 appearance-none leading-normal"
                  placeholder="currency_from"
                  as="select"
                  name={`currency_from`}
                >
                  <option value="">Select Currency</option>
                  {
                    JSON.parse(props.currencies).map(item => <option key={item.code} value={item.code}>{item.name}</option>)
                  }
                </Field>
              </div>
              <div class="mt-6 flex">
                <Field
                  type="number"
                  placeholder="Value From"
                  name={`value_to`}
                  className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-1/4 mr-8 appearance-none leading-normal"
                  disabled={true}
                  value={valueTo}
                />
                <Field
                  type="text"
                  placeholder="currency_to"
                  className="bg-white focus:outline-none focus:shadow-outline border border-gray-300 rounded-lg py-2 px-4 block w-3/4 appearance-none leading-normal"
                  as="select"
                  name={`currency_to`}
                >
                  <option value="">Select Currency</option>
                  {
                    JSON.parse(props.currencies).map(item => <option key={item.code} value={item.code}>{item.name}</option>)
                  }
                </Field>
              </div>
              <br />
              <button className="bg-green-500 rounded text-white shadow p-2 w-2/12 text-center mr-4">Exchange</button>
            </form>
          )}
      </Formik>
    </div>
  )
}

export default FormExchange