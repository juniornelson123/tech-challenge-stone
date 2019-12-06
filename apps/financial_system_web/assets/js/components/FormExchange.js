import React, { useState } from 'react'
import { Formik, Field } from 'formik'
import { exchange } from '../services'

function FormExchange(props) {
  const [valueTo, setValueTo] = useState(0)

  return(
    <>
      <div>
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
                <Field
                  type="number"
                  placeholder="Value From"
                  name={`value_from`}
                />
                <Field
                  type="text"
                  placeholder="currency_from"
                  as="select"
                  name={`currency_from`}
                >
                  <option value="">Select Currency</option>
                  {
                    JSON.parse(props.currencies).map(item => <option key={item.code} value={item.code}>{item.name}</option>)
                  }
                </Field>
                <Field
                  type="number"
                  placeholder="Value From"
                  name={`value_to`}
                  disabled={true}
                  value={valueTo}
                />
                <Field
                  type="text"
                  placeholder="currency_to"
                  as="select"
                  name={`currency_to`}
                >
                  <option value="">Select Currency</option>
                  {
                    JSON.parse(props.currencies).map(item => <option key={item.code} value={item.code}>{item.name}</option>)
                  }
                </Field>
                <br />
                <button>Exchange</button>
              </form>
            )}
        </Formik>
      </div>
    </>
  )
}

export default FormExchange