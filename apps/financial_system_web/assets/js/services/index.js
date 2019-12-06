import { create } from 'apisauce'

const api = create({
  baseURL: '/api',
  headers: { Accept: 'application/json' },
})

const getAccounts = async () => await api.get('/accounts')

const createTransfer = async (id, transfer) => await api.post(`/accounts/${id}/transfers`, {transfer: transfer})

const exchange = async (currency_from, currency_to, value) => await api.post(`/exchanges`, { currency_from, currency_to, value})

export {
  getAccounts,
  createTransfer,
  exchange
}