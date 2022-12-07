def lambda1(event, context):
    message = 'hello {} ! '.format(event['key1'])
    return {
        'message' : message
    }