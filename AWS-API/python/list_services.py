import boto3
from datetime import datetime, timedelta
from botocore.exceptions import ClientError
import csv


def billingresourcelist(num_days=1):
    end_date = datetime.today().date()
    start_date = end_date - timedelta(days=num_days)
    end_date_str = end_date.strftime('%Y-%m-%d')

    session = boto3.Session()

    ce_client = session.client('ce')
    results = ce_client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date.strftime('%Y-%m-%d'),
            'End': end_date_str
        },
        Granularity='DAILY',
        Metrics=['UnblendedCost'],
        GroupBy=[
            {
                'Type': 'DIMENSION',
                'Key': 'REGION'
            },
            {
                'Type': 'DIMENSION',
                'Key': 'SERVICE'
            }
        ]
    )
    services_by_region = {}

    for result in results['ResultsByTime']:
        for group in result['Groups']:
            cost = float(group['Metrics']['UnblendedCost']['Amount'])
            if cost > 0.1:
                region = group['Keys'][0]
                service = group['Keys'][1]
                if region not in services_by_region:
                    services_by_region[region] = set()
                services_by_region[region].add(service)

    for region, services in services_by_region.items():
        print(f"{region}: {list(services)}")

    return None


def tocsv(payload, filename='output.csv'):
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Region', 'ARN'])
        for region, arns in payload.items():
            for arn in arns:
                writer.writerow([region, arn['arn'], arn['Name']])
    print(f'Data has been written to {filename}!')


def getnamefromtag(payload):
    try:
        for i in payload:
            if i.get('Key') == 'Name':
                return i.get('Value')
        return 'N/A'
    except:
        return 'N/A'


def getresourcesarn():
    data = {}
    session = boto3.session.Session()
    regions = session.get_available_regions()
    for region in regions:
        try:
            client = boto3.client('resourcegroupstaggingapi')
            response = client.get_resources()
            arn_list = [{'arn': x.get('ResourceARN'), 'Name': getnamefromtag(x.get('Tags'))} for x in response.get('ResourceTagMappingList')]
            token = response.get('PaginationToken')
            while True:
                response = client.get_resources(PaginationToken=token)
                arn_list.extend([{'arn': x.get('ResourceARN'), 'Name': getnamefromtag(x.get('Tags'))} for x in response.get('ResourceTagMappingList')])
                if not response.get('PaginationToken'):
                    break
                else:
                    token = response.get('PaginationToken')
            data[region] = arn_list
            tocsv(data, f'{region}.csv')
        except ClientError as e:
            print(f'Unable to fetch data from region - region with error: {e}')
    return None


if __name__ == '__main__':
    billingresourcelist()
    getresourcesarn()