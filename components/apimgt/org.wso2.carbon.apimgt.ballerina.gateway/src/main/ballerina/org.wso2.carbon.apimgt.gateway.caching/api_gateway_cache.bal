// Copyright (c)  WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/cache;
import org.wso2.carbon.apimgt.gateway.constants as constants;
import org.wso2.carbon.apimgt.gateway.dto as dto;


cache:Cache gatewayKeyValidationCache = new;
cache:Cache invalidTokenCache = new;

public type APIGatewayCache object {


   public function authenticateFromGatewayKeyValidationCache(string tokenCacheKey) returns (dto:APIKeyValidationDto|());

   public function addToGatewayKeyValidationCache (string tokenCacheKey, dto:APIKeyValidationDto apiKeyValidationDto) ;

   public function removeFromGatewayKeyValidationCache (string tokenCacheKey);

   public function retrieveFromInvalidTokenCache(string tokenCacheKey) returns (boolean|());

   public function removeFromInvalidTokenCache (string tokenCacheKey);

   public function addToInvalidTokenCache (string tokenCacheKey, boolean authorize) ;
};

public function APIGatewayCache::authenticateFromGatewayKeyValidationCache(string tokenCacheKey) returns (dto:APIKeyValidationDto|()) {
    match <dto:APIKeyValidationDto> gatewayKeyValidationCache.get(tokenCacheKey){
        dto:APIKeyValidationDto apikeyValidationDto => {
            return apikeyValidationDto;
        }
        error err => {
            return ();
        }
    }
}

public function APIGatewayCache::addToGatewayKeyValidationCache (string tokenCacheKey, dto:APIKeyValidationDto
    apiKeyValidationDto) {
    gatewayKeyValidationCache.put(tokenCacheKey, apiKeyValidationDto);
}

public function APIGatewayCache::removeFromGatewayKeyValidationCache (string tokenCacheKey) {
    gatewayKeyValidationCache.remove(tokenCacheKey);
}

public function APIGatewayCache::retrieveFromInvalidTokenCache(string tokenCacheKey) returns (boolean|()) {
    match <boolean> invalidTokenCache.get(tokenCacheKey){
        boolean authorize => {
            return authorize;
        }
        error err => {
            return ();
        }
    }
}

public function APIGatewayCache::addToInvalidTokenCache (string tokenCacheKey, boolean authorize) {
    invalidTokenCache.put(tokenCacheKey, authorize);
}

public function APIGatewayCache::removeFromInvalidTokenCache (string tokenCacheKey) {
    invalidTokenCache.remove(tokenCacheKey);
}