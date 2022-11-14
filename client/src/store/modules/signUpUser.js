import axios from 'axios'

const API_URL = process.env.VUE_APP_AWS_DNS_NAME || 'http://minip-loadb-1dljk7sx4pzu7-67c7b3409686a1f1.elb.eu-west-3.amazonaws.com:4000/api'

const signUpUser = {
    namespaced: true,
    actions: {
        async signUp({ username, email, password, role }) {
            try {
                const { status } = await axios.post(`${API_URL}/signUp`, { user: { username, email, password, role } })
                return { status }
            } catch ({ response }) {
                return { error: response.error, status: response.status }
            }
        }

    }
}

export default signUpUser
