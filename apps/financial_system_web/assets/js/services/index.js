import { create } from 'apisauce'

const api = create({
  baseURL: '/api',
  headers: { Accept: 'application/json' },
})

const getAccounts = async () => await api.get('/accounts')

const createTransfer = async (id, transfer) => await api.post(`/accounts/${id}/transfers`, {transfer: transfer})

export {
  getAccounts,
  createTransfer
}